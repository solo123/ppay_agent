class BankCardsController < ApplicationController
  before_action :set_bank_card, only: [:show, :edit, :update, :destroy]

  # GET /bank_cards
  # GET /bank_cards.json
  def index
    @bank_cards = BankCard.all
  end

  # GET /bank_cards/1
  # GET /bank_cards/1.json
  def show
  end

  # GET /bank_cards/new
  def new
    @bank_card = BankCard.new
  end

  # GET /bank_cards/1/edit
  def edit
  end

  # POST /bank_cards
  # POST /bank_cards.json
  def create
    @bank_card = BankCard.new(bank_card_params)

    respond_to do |format|
      if @bank_card.save
        format.html { redirect_to @bank_card, notice: 'Bank card was successfully created.' }
        format.json { render :show, status: :created, location: @bank_card }
      else
        format.html { render :new }
        format.json { render json: @bank_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_cards/1
  # PATCH/PUT /bank_cards/1.json
  def update
    respond_to do |format|
      if @bank_card.update(bank_card_params)
        format.html { redirect_to @bank_card, notice: 'Bank card was successfully updated.' }
        format.json { render :show, status: :ok, location: @bank_card }
      else
        format.html { render :edit }
        format.json { render json: @bank_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_cards/1
  # DELETE /bank_cards/1.json
  def destroy
    @bank_card.destroy
    respond_to do |format|
      format.html { redirect_to bank_cards_url, notice: 'Bank card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_card
      @bank_card = BankCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_card_params
      params.require(:bank_card).permit(:bank_name, :bank_sub_branch, :account_name, :account_number)
    end
end
