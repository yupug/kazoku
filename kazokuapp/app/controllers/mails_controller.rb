class MailsController < ApplicationController
  # GET /mails
  # GET /mails.json
  def index
    @mails = Mail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @mails }
    end
  end

  # GET /mails/1
  # GET /mails/1.json
  def show
    @mail = Mail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @mail }
    end
  end

  # GET /mails/new
  # GET /mails/new.json
  def new
    @mail = Mail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @mail }
    end
  end

  # GET /mails/1/edit
  def edit
    @mail = Mail.find(params[:id])
  end

  # POST /mails
  # POST /mails.json
  def create
    @mail = Mail.new(params[:mail])

    respond_to do |format|
      if @mail.save
        format.html { redirect_to @mail, :notice => 'Mail was successfully created.' }
        format.json { render :json => @mail, :status => :created, :location => @mail }
      else
        format.html { render :action => "new" }
        format.json { render :json => @mail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mails/1
  # PUT /mails/1.json
  def update
    @mail = Mail.find(params[:id])

    respond_to do |format|
      if @mail.update_attributes(params[:mail])
        format.html { redirect_to @mail, :notice => 'Mail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @mail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mails/1
  # DELETE /mails/1.json
  def destroy
    @mail = Mail.find(params[:id])
    @mail.destroy

    respond_to do |format|
      format.html { redirect_to mails_url }
      format.json { head :no_content }
    end
  end
end
