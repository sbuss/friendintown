module FeedbackHelper
  def feedback_link(link_text, params)
    # Since this is in the footer, it's safe to do this
    unless current_page?(new_feedback_path) || current_page?(feedbacks_path) 
      store_feedback_last_page 
    end
    link_to(link_text, new_feedback_path) 
  end
end
