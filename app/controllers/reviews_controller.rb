class ReviewsController < ApplicationController
  before_action :find_review, only: [:show, :edit, :destroy, :update]
  before_action :arcs_and_ratings, only: [:new, :edit]
  def index
    if logged_in?
      current_user
      @reviews = current_user.reviews
    else
      @reviews = Review.all
    end
  end

  def show
  end

  def new
    @review = Review.new
    @users = User.all
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to architecture_path(@review.architecture)
    else
      flash[:error] = @review.errors.full_messages
      redirect_to new_review_path
    end
  end

  def edit
  end

  def update
    @review.update(review_params)
    if @review.valid?
      redirect_to '/'
    else
      flash[:error] = @review.errors.full_messages
      redirect_to edit_review_path
    end
  end

  def destroy
    @review.destroy
    redirect_to '/'
  end

  private

  def find_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating, :architecture_id)
  end

  def arcs_and_ratings
    @architectures = Architecture.sorted
    @ratings = [5,4,3,2,1]
  end

end
