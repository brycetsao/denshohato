require "./zerojudge"
require "./greenjudge"

module DenshoHato
  def submit judge, prob, lang, code
    case judge
    when "ZeroJudge"
      ZeroJudge::submit prob, lang, code
    when "GreenJudge"
      GreenJudge::submit prob, lang, code
    else
      raise "Error: Judge Not Supported"
    end
  end
end
