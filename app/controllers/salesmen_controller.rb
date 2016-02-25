class SalesmenController < ApplicationController
  def index
    params[:q] ||= {}
    all_salesman = current_user.agent.salesmen

    @q = all_salesman.ransack(params[:q])
    pages = $redis.get(:list_per_page) || 100
    @collection = @q.result
      .includes(:clients)
      .page(params[:page]).per( pages )

  end

  def show
    @object_hash = salesman_detail Salesman.find(params[:id])
  end

  def salesman_detail(salesman)
    ret = {
      "contact.name"=>salesman.name, 'contact.tel'=>'', 'join_date'=>Date.current,
      'status'=>'正常'
    }
    if salesman.contact_id
        contact = Contact.find(salesman.contact_id)
        ret['conact.name'] = contact.name if contact.name
        ret['conact.tel'] = contact.name if contact.tel
    end
    ret['url'] = salesman_path(salesman)
    return ret


  end
end
