class TransactionsController < ApplicationController
  before_filter :authenticate_user!
  # GET /transactions
  # GET /transactions.json

  def balance_sheet
    txs = Transaction.all
    @assets = 0
    @other = 0
    @A = {}
    @P = {}
    txs.each do |tx|
      if tx.debit_account.a_type == 'assets' or tx.debit_account.a_type == 'expenses'
        @assets += tx.amount
        @A[tx.debit_account.name] = 0 unless @A.has_key?(tx.debit_account.name)
        @A[tx.debit_account.name] += tx.amount
      else
        @other -= tx.amount
        @P[tx.debit_account.name] = 0 unless @P.has_key?(tx.debit_account.name)
        @P[tx.debit_account.name] -= tx.amount
      end

      if tx.credit_account.a_type == 'assets' or tx.credit_account.a_type == 'expenses'
        @assets -= tx.amount
        @A[tx.credit_account.name] = 0 unless @A.has_key?(tx.credit_account.name)
        @A[tx.credit_account.name] -= tx.amount
      else
        @other += tx.amount
        @P[tx.credit_account.name] = 0 unless @P.has_key?(tx.credit_account.name)
        @P[tx.credit_account.name] += tx.amount
      end      
    end
  end

  def index
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.json
  def new
    @transaction = Transaction.new
    @accounts = Account.find(:all, :order => :id)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
    @accounts = Account.find(:all, :order => :id)
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render json: @transaction, status: :created, location: @transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transactions/1
  # PUT /transactions/1.json
  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end
end
