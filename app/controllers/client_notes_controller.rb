class ClientNotesController < ApplicationController
  before_action :set_client_note, only: [:show, :edit, :update, :destroy]

  # GET /client_notes
  # GET /client_notes.json
  def index
    @client_notes = ClientNote.all
  end

  # GET /client_notes/1
  # GET /client_notes/1.json
  def show
  end

  # GET /client_notes/new
  def new
    @client_note = ClientNote.new
  end

  # GET /client_notes/1/edit
  def edit
  end

  # POST /client_notes
  # POST /client_notes.json
  def create
    @client_note = ClientNote.new(client_note_params)

    respond_to do |format|
      if @client_note.save
        format.html { redirect_to @client_note, notice: 'Client note was successfully created.' }
        format.json { render :show, status: :created, location: @client_note }
      else
        format.html { render :new }
        format.json { render json: @client_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_notes/1
  # PATCH/PUT /client_notes/1.json
  def update
    respond_to do |format|
      if @client_note.update(client_note_params)
        format.html { redirect_to @client_note, notice: 'Client note was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_note }
      else
        format.html { render :edit }
        format.json { render json: @client_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_notes/1
  # DELETE /client_notes/1.json
  def destroy
    @client_note.destroy
    respond_to do |format|
      format.html { redirect_to client_notes_url, notice: 'Client note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_note
      @client_note = ClientNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_note_params
      params.require(:client_note).permit(:note, :type)
    end
end
