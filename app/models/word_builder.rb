class WordBuilder << Wordalysis
  has_one: text

  def clean_up
    self.text.downcase!.gsub!(/<\/?[^>]*>/, "").gsub!(/[^a-z '-]/, '')
  end

  def get_freqs
    self.text = self.text.split
    freq_hash = Hash.new(0)
    text.each do |word|
      unless freq_hash.key?(word)
        freq_hash[word] = 1
      else
        freq_hash[word] += 1
      end
    end
    return freq_hash
  end



end
