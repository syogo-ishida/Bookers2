class BookCommentsController < ApplicationController
  class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment.user_id = current_user.id
    if @book_comment.save
      redirect_back(fallback_location: book_path(@book))
    else
      @book = Book.new
      @book_detail = Book.find(params[:book_id])
      @user = User.find(@book_detail.user_id)
      render 'books/show'
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], user_id: current_user.id, book_id: params[:book_id]).destroy
    redirect_back(fallback_location: book_path(params[:book_id]))
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
end
