# frozen_string_literal: true

# controller for contact us
class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = current_user.contacts.build(contact_params)
    if @contact.save
      redirect_to root_path, notice: 'Sent successfully.'
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:subject, :body)
  end
end
