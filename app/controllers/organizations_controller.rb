class OrganizationsController < ApplicationController
  
  def index
    orgs = Organization.order('created_at DESC')
    render json: orgs, status: :ok
  end
end
