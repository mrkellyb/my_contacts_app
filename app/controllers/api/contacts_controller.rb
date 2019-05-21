class Api::ContactsController < ApplicationController

  before_action :authenticate_user

  def index
    @contacts = Contact.all

    if params[:first_name]
      @contacts = @contacts.where("first_name iLIKE ?", "%#{params[:first_name]}%")
    end

    if params[:middle_name]
      @contacts = @contacts.where("middle_name iLIKE ?", "%#{params[:middle_name]}%")
    end

    if params[:last_name]
      @contacts = @contacts.where("last_name iLIKE ?", "%#{params[:last_name]}%")
    end

    if params[:email]
      @contacts = @contacts.where("email iLIKE ?", "%#{params[:email]}%")
    end

    if params[:phone_number]
      @contacts = @contacts.where("phone_number iLIKE ?", "%#{params[:phone_number]}%")
    end    


    render "index.json.jbuilder"
  end

  def create
    # PRINTS COORDS TO SERVER LOG!
    # coordinates = Geocoder.coordinates(params[:address])
    # p "============================#{coordinates}"
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      address: params[:address],
      bio: params[:bio],
      user_id: current_user.id

      # latitude: coordinates[0],
      # longitude: coordinates[1]
      )
    if @contact.save
      render "show.json.jbuilder"
    else
      render json: {errors: @contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @contact = Contact.find(params[:id])
    render "show.json.jbuilder"
  end

  def update
    @contact = Contact.find(params[:id])

    @contact.first_name = params[:first_name] || @contact.first_name
    @contact.middle_name = params[:middle_name] || @contact.middle_name
    @contact.last_name = params[:last_name] || @contact.last_name
    @contact.email = params[:email] || @contact.email
    @contact.phone_number = params[:phone_number] || @contact.phone_number
    @contact.address = params[:address] || @contact.address
    @contact.bio = params[:bio] || @contact.bio

    # PRINTS COORDS TO SERVER LOG!
    # coordinates = Geocoder.coordinates(params[:address])
    # p "============================#{coordinates}"  

    # @contact.latitude = coordinates[0] || @contact.latitude
    # @contact.longitude = coordinates[1] || @contact.longitude

    if @contact.save
      render "show.json.jbuilder"
    else
      render json: {errors: @contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: {message: "Contact destroyed"}
  end


end
