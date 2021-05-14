module ScoreCalculator 
  def rank_value
    {
      "2" => 2, 
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "10" => 10,
      "J" => 10,
      "K" => 10,
      "Q" => 10,
      "A" => 10
    }
  end 

  def score_look_up(rank)
    return rank_value[rank] if rank 

    raise "Unable to find Value for Corresponding Rank: #{rank}"
  end 
end 
