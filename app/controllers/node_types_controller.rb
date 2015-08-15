class NodeTypesController < ApplicationController
	before_filter :authenticate_user
  
	def new
		@nodeType = NodeType.new
	end

	def index
		@nodeTypes = NodeType.all
  	end

  	def create
   		@nodeType = NodeType.new(nodeType_params)

	    if @nodeType.save
    	   redirect_to @nodeType
    	else
    	   render :new
    	end
  	end

	def edit
    	@nodeType = NodeType.find(params[:id])
  	end

  	def update
      @nodeType = NodeType.find(params[:id])

      if @nodeType.update_attributes(nodeType_params)
        redirect_to @nodeType
      else
        render :edit
      end
  end

  	def show
  		@nodeType = NodeType.find(params[:id])
  	end

  	private
  		def nodeType_params
  			params.require(:node_type).permit(:name, :priorityEnabled)
  		end
end