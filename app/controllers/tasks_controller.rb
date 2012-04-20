class TasksController < ApplicationController


  def index
    @todo   = Task.where(:done => false)
    @task   = Task.new
    @lists  = List.all
    @list   = List.new
    
    respond_to do |format|
      format.html
    end
  end


  def create
    @list = List.find(params[:list_id])
    @task = @list.tasks.new(params[:task])
    if @task.save
        flash[:notice] = "Your task was created."
    else
        flash[:alert] = "There was an error creating your task."
    end
    redirect_to(list_tasks_url(@list))
  end

  def create_sms
    @list = List.find(1)
    @task = @list.tasks.new(:name => params[:Body], :phone => params[:From])
    if @task.save
      render :text => '<Response><Sms>Awesome, thanks for the tip</Sms></Response>', :content_type => "text/xml"
    else
      render :text => '<Response><Sms>Sad Panda :(</Sms></Response>', :content_type => 'text/xml'
    end
  end

  def update
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])

    account_sid = 'ACbbefae45e9c349aa931498bd315c85e1'
    auth_token = '748a6fa66c8d70882fdbb9424b5c0944'
    @client = Twilio::REST::Client.new account_sid, auth_token

    if @task.phone
      @client.account.sms.messages.create(
        :from => '4155992671',
        :to => @task.phone,
        :body => @task.name + ' has been completed!'
        )
    end

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to( list_tasks_url(@list), :notice => 'Task was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(list_tasks_url(@list)) }
    end
  end
  
 
end
