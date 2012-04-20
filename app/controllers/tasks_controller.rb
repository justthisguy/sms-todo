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
