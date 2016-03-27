class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user
    before_filter :authorized_only

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @has_responses = QuestionHasResponse.where(:question_id => @question)
    @answer = QuestionHasResponse.where(:question_id => @question, :answers => true)
  end

  # GET /questions/new
  def new
    @node = Node.find(params[:format])
    @question = Question.new(:node_id => @node.id)

    set_parents

  end

  def set_parents
    @parents = Array.new
    @i = @question.node
    while @i.parent != nil do 
      @parents << @i.parent
      @i = @i.parent
    end
  end

  # GET /questions/1/edit
  def edit
    set_parents

  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        add_activity_to_subscribers_inbox(@question.create_activity :create, owner: @current_user)
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        add_activity_to_subscribers_inbox(@question.create_activity :update, owner: @current_user)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :node_id, :phase_id, :resolved_id, :asked_by_user_id)
    end
end
