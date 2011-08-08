class WordDay
  include MongoMapper::Document
  include Raingrams
  key :time_date, Time
  key :org_id
  key :type
  key :word_hash
  key :bigram_hash
  key :is_global

  def initialize(text,type,org_id)
    make_word_hash(text)
    make_bigram_hash(text)
    self.time_date = Time.now
    self.type = type
    if org_id.nil? then self.is_global = true
    else self.org_id = org_id end
    self.save
  end

  def make_word_hash(text)
    words = pull_stopwords(text.downcase.gsub(/<\/?[^>]*>/, "").gsub(/[^a-z '-]/, '').split)
    freq_hash = Hash.new(0)
    words.each do |word|
      if freq_hash.key?(word)
        freq_hash[word] += 1
      else
        freq_hash[word] = 1
      end
    end
    self.word_hash = freq_hash
  end

  def make_bigram_hash(text)
    hash = {}
    words = text.downcase.gsub(/<\/?[^>]*>/, "")
    model = BigramModel.build
    # using sentence gets rid of <s> tags
    bigrams = model.frequencies_for(model.train_with_sentence(words))
    bigrams.each do |bigram|
      gram = simplify_bigram(bigram)
      unless gram.nil?
        hash[gram[0]] = gram[1]
      end
    end
    self.bigram_hash = hash
  end

  #An attempt to circumvent issues with translating the bigram format
  #into bison; this is behaving strangely currently.
  def simplify_bigram(bigram)
    gram = []
    gram[0] = bigram.first.to_s #.split(",").delete_if {|x| x.include?("s>")}
    if gram[0].include?("s>") then return nil
    else
      gram[1] = bigram[1]
      return gram
    end
  end

  def pull_stopwords(words)
    stopwords = ["a", "about", "above", "across", "after", "again", "against", "all", "almost", "alone", "along", "already", "also", "although", "always", "among", "an", "and", "another", "any", "anybody", "anyone", "anything", "anywhere", "are", "area", "areas", "around", "as", "ask", "asked", "asking", "asks", "at", "away", "b", "back", "backed", "backing", "backs", "be", "became", "because", "become", "becomes", "been", "before", "began", "behind", "being", "beings", "best", "better", "between", "big", "both", "but", "by", "c", "came", "can", "cannot", "case", "cases", "certain", "certainly", "clear", "clearly", "come", "could", "d", "did", "differ", "different", "differently", "do", "does", "done", "down", "down", "downed", "downing", "downs", "during", "e", "each", "early", "either", "end", "ended", "ending", "ends", "enough", "even", "evenly", "ever", "every", "everybody", "everyone", "everything", "everywhere", "f", "face", "faces", "fact", "facts", "far", "felt", "few", "find", "finds", "first", "for", "four", "from", "full", "fully", "further", "furthered", "furthering", "furthers", "g", "gave", "general", "generally", "get", "gets", "give", "given", "gives", "go", "going", "good", "goods", "got", "great", "greater", "greatest", "group", "grouped", "grouping", "groups", "h", "had", "has", "have", "having", "he", "her", "here", "herself", "high", "high", "high", "higher", "highest", "him", "himself", "his", "how", "however", "i", "if", "important", "in", "interest", "interested", "interesting", "interests", "into", "is", "it", "its", "itself", "j", "just", "k", "keep", "keeps", "kind", "knew", "know", "known", "knows", "l", "large", "largely", "last", "later", "latest", "least", "less", "let", "lets", "like", "likely", "long", "longer", "longest", "m", "made", "make", "making", "man", "many", "may", "me", "member", "members", "men", "might", "more", "most", "mostly", "mr", "mrs", "much", "must", "my", "myself", "n", "necessary", "need", "needed", "needing", "needs", "never", "new", "new", "newer", "newest", "next", "no", "nobody", "non", "noone", "not", "nothing", "now", "nowhere", "number", "numbers", "o", "of", "off", "often", "old", "older", "oldest", "on", "once", "one", "only", "open", "opened", "opening", "opens", "or", "order", "ordered", "ordering", "orders", "other", "others", "our", "out", "over", "p", "part", "parted", "parting", "parts", "per", "perhaps", "place", "places", "point", "pointed", "pointing", "points", "possible", "present", "presented", "presenting", "presents", "problem", "problems", "put", "puts", "q", "quite", "r", "rather", "really", "right", "right", "room", "rooms", "s", "said", "same", "saw", "say", "says", "second", "seconds", "see", "seem", "seemed", "seeming", "seems", "sees", "several", "shall", "she", "should", "show", "showed", "showing", "shows", "side", "sides", "since", "small", "smaller", "smallest", "so", "some", "somebody", "someone", "something", "somewhere", "state", "states", "still", "still", "such", "sure", "t", "take", "taken", "than", "that", "the", "their", "them", "then", "there", "therefore", "these", "they", "thing", "things", "think", "thinks", "this", "those", "though", "thought", "thoughts", "three", "through", "thus", "to", "today", "together", "too", "took", "toward", "turn", "turned", "turning", "turns", "two", "u", "under", "until", "up", "upon", "us", "use", "used", "uses", "v", "very", "w", "want", "wanted", "wanting", "wants", "was", "way", "ways", "we", "well", "wells", "went", "were", "what", "when", "where", "whether", "which", "while", "who", "whole", "whose", "why", "will", "with", "within", "without", "work", "worked", "working", "works", "would", "x", "y", "year", "years", "yet", "you", "young", "younger", "youngest", "your", "yours", "z"]
    return words - stopwords
  end

  # own_hash would be self.word_hash or self.bigram_hash (or others, in the future)
  def add_hash(own_hash, small_hash)
    small_hash.each do |item|
      if own_hash.key?(item[0])
        own_hash[item[0]] += item[1]
      else
        own_hash[item[0]] = item[1]
      end
    end
    self.save
  end

  def sort_hash(hash)
    return hash.to_a.sort_by! {|x,y| -y}
  end

end
