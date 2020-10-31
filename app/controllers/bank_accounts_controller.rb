class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: [:show, :edit, :update, :destroy]
  before_action :set_customers, only: [:new, :create, :edit, :update]

  # GET /bank_accounts
  # GET /bank_accounts.json
  def index
    @bank_accounts = BankAccount.all
  end

  # GET /bank_accounts/1
  # GET /bank_accounts/1.json
  def show
  end

  # GET /bank_accounts/new
  def new
    @bank_account = BankAccount.new
  end

  # GET /bank_accounts/1/edit
  def edit
  end

  # POST /bank_accounts
  # POST /bank_accounts.json
  def create
    @bank_account = BankAccount.new(bank_account_params)

    respond_to do |format|
      if @bank_account.save
        dob = get_customer_age(@bank_account.customer_id)
        @bank_account.update_attributes(minor_indicator:  dob < 18)
        format.html { redirect_to @bank_account, notice: 'Bank account was successfully created.' }
        format.json { render :show, status: :created, location: @bank_account }
      else
        format.html { render :new }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_accounts/1
  # PATCH/PUT /bank_accounts/1.json
  def update
    respond_to do |format|
      if @bank_account.update(bank_account_params)
        dob = get_customer_age(@bank_account.customer_id)
        @bank_account.update_attributes(minor_indicator:  dob < 18)        
        format.html { redirect_to @bank_account, notice: 'Bank account was successfully updated.' }
        format.json { render :show, status: :ok, location: @bank_account }
      else
        format.html { render :edit }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_accounts/1
  # DELETE /bank_accounts/1.json
  def destroy
    @bank_account.destroy
    respond_to do |format|
      format.html { redirect_to bank_accounts_url, notice: 'Bank account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_account_params
      params.require(:bank_account).permit(:account_type, :open_date, :customer_id, :customer_name, :branch, :minor_indicator)
    end

    def set_customers
      response = RestClient.get(
        "#{AUTH_APP_URL}/customers"
      )

      data = JSON.parse(response.body)

      if data['errors'].present?
        @customers = nil
      else
        @customers = data['customers']
      end      
    end

    def get_customer_age(c_id)
      response = RestClient.get(
        "#{AUTH_APP_URL}/customers/#{c_id}/get_customer_age"
      )

      data = JSON.parse(response.body)
      if data['errors'].present?
        nil.to_i
      else
        data['dob'].to_i
      end      
    end    
end
