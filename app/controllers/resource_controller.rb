class ResourceController < ApplicationController
  respond_to :html, :js, :json

  def initialize
    super
    @m_fields = [1]
    @sum_fields = [1]

    @table_head = 'table_head'
    @field_titles = ['1', '2', '3', '4']
  end

  def index
    @curmodel = object_name.classify.constantize.new

    # return @collection if @collection.present?
    load_collection

    len = object_name.classify.constantize.new.attributes.keys.count

    tmp = Array.new(len-3, 0.00)
    @summary = Array.new(len-3, '')
    @summary[0] = '汇总信息'

    @q.result(distinct: true).each do |item|
      @sum_fields.each do |index|
        tmp[index-1] += item.attributes.values.at(index).to_f
      end
    end

    for index in 1..(len-3) do
      @summary[index] = tmp[index]== 0.0 ? '': tmp[index].to_s
    end


  end
  def show
    load_object
  end
  def edit
    load_object
  end
  def new
    @object = object_name.classify.constantize.new
  end
  def update
    load_object
    params.permit!
    @object.attributes = params[object_name.singularize.parameterize('_')]
    if @object.changed_for_autosave?
      @changes = @object.changes
      if @object.save
      else
        flash[:error] = @object.errors.full_messages.to_sentence
        @no_log = 1
      end
    end
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.js
    end
  end
  def create
    params.permit!
    @object = object_name.classify.constantize.new(params[object_name.singularize.parameterize('_')])
    @object.creator = current_employee.employee_info if @object.has_attribute? :creator_id
    if @object.save
    else
      flash[:error] = @object.errors.full_messages.to_sentence
      @no_log = 1
    end
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.js
    end
  end
  def destroy
    load_object
    if @object.status && @object.status > 0
      @object.status = 0
    else
      @object.status = 1
    end
    @object.save
  end

  protected

  def load_collection
    params[:q] ||= {}
    params[:all_query] ||= ''
    if params[:all_query].to_s.empty?
      @q = object_name.classify.constantize.ransack( params[:q] )
    else
      tmp  =  {'m'=>'or'}
      for k in object_name.classify.constantize.new.attributes.keys[1..-3] do
        tmp[k.to_s +  '_cont'] = params[:all_query]
      end
      @q = object_name.classify.constantize.ransack(tmp)
    end
    pages = $redis.get(:list_per_page) || 100
    @collection = @q.result(distinct: true).page(params[:page]).per( pages )


  end

  def load_object
    @object = object_name.classify.constantize.find_by_id(params[:id])
  end
  def object_name
    controller_name #.singularize
  end

  def flash_message_for(object, event_sym)
    resource_desc  = object.class.model_name.human
    resource_desc += " \"#{object.name}\"" if object.respond_to?(:name) && object.name.present?
    I18n.t(event_sym, :resource => resource_desc)
  end

  # Index request for JSON needs to pass a CSRF token in order to prevent JSON Hijacking
  def check_json_authenticity
    return unless request.format.js? or request.format.json?
    return unless protect_against_forgery?
    auth_token = params[request_forgery_protection_token]
    unless (auth_token and form_authenticity_token == URI.unescape(auth_token))
      raise(ActionController::InvalidAuthenticityToken)
    end
  end

  # URL helpers

  def new_object_url(options = {})
    if parent_data.present?
      new_polymorphic_url([:admin, parent, model_class], options)
    else
      new_polymorphic_url([:admin, model_class], options)
    end
  end

  def edit_object_url(object, options = {})
    if parent_data.present?
      send "edit_#{model_name}_#{object_name}_url", parent, object, options
    else
      send "edit_#{object_name}_url", object, options
    end
  end

  def object_url(object = nil, options = {})
    target = object ? object : @object
    if parent_data.present?
      send "#{model_name}_#{object_name}_url", parent, target, options
    else
      send "#{object_name}_url", target, options
    end
  end

  def collection_url(options = {})
    if parent_data.present?
      polymorphic_url([parent, model_class])
    else
      polymorphic_url(model_class)
    end
  end


end
