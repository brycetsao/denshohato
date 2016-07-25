require "mechanize"

module ZeroJudge
  def self.submit prob, lang, code
    agent = Mechanize.new
    #log in
    agent.get "http://zerojudge.tw/Login"
    form = agent.page.form
    form.account = "kiwijudge"
    form.passwd = ""
    form.submit
    #submit
    payload = { 'action' => 'SubmitCode', 'problemid' => prob, 'language' => lang, 'code' => code }
    agent.post "http://zerojudge.tw/Solution.api", payload
    #get result
    agent.get "http://zerojudge.tw/Submissions"
    solutionid = agent.page.root.at_css('#solutionid').text
    result_payload = { 'action' => 'getSummary', 'solutionid' => solutionid }
    begin
      sleep 0.5
      res = agent.post "http://zerojudge.tw/Solution.api", result_payload
    end while JSON.parse(res.root)["judgement"] == "Waiting"
    #log out
    agent.get "http://zerojudge.tw/Logout"
    return JSON.parse(res.root)["judgement"]
  end
end
