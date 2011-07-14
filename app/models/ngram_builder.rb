class NgramBuilder << Wordalysis
  include Raingrams
  has_one: text

  def clean_up
    self.text.downcase!.gsub!(/<\/?[^>]*>/, "")
  end

  def get_freqs
    model = BigramModel.build
    # using sentence gets rid of <s> tags
    ngrams = model.frequencies_for(model.train_from_sentence(text))
    return ngrams
  end

end
