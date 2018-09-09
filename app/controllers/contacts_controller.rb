# frozen_string_literal: true

# controller for contact us
class ContactsController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]

  def new
    @contact = Contact.new
  end

  def create
    @contact = if current_user
                 current_user.contacts.build(contact_params)
               else
                 Contact.new(contact_params)
               end

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
