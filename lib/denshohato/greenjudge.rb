require "mechanize"

module GreenJudge
  def self.submit prob, lang, code
    agent = Mechanize.new
    #log in
    agent.get "http://www.tcgs.tc.edu.tw:1218/Login"
    form = agent.page.form
    form.Account = "kiwijudge"
    form.UserPasswd = ""
    form.submit
    #submit
    agent.get "http://www.tcgs.tc.edu.tw:1218/SolutionForm?problemid=" + prob
    form = agent.page.form
    form.code = code
    form.submit
    #get result
    agent.get "http://www.tcgs.tc.edu.tw:1218/RealtimeStatus"
    solutionid = agent.page.root.at_css("#solutionid").text
    begin
      sleep 0.5
      agent.get "http://www.tcgs.tc.edu.tw:1218/RealtimeStatus"
      status = agent.page.root.at_css("#ajaxstatus_" + solutionid.to_s).text.split.first
    end while status == "Waiting..."
    #log out
    agent.get "http://www.tcgs.tc.edu.tw:1218/Logout"
    return status
  end
end
