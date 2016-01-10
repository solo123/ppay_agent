class AgentsController < ResourceController
  def create_login
  end
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    # def agent_params
    #   params.require(:agent).permit(
    #     :id,
    #     :cooperation_date, :cooperation_type_id,
    #     :t0_enabled, :bank_biz_types,
    #     :cooperation_location, :deposit,
    #     :amounts_payable,
    #     company_attributes: [:name, :short_name],
    #   )
    # end

end
