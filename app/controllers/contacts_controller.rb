class ContactsController < ApplicationController

  def create
    @company = Company.find(params[:company_id])
    @company.contacts.create(contact_params)

    redirect_to company_jobs_path(@company)
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :position, :email)
  end
end
