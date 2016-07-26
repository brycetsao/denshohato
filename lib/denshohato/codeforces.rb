require "mechanize"

module CodeForces
  def self.submit prob, lang, code
    agent = Mechanize.new
    #log in
    agent.get "http://codeforces.com/enter"
    form = agent.page.form
    form.handle = "WLSH"
    form.password = ""
    form.submit
    #submit
    agent.get "http://codeforces.com/problemset/submit"
    form.submittedProblemCode = prob
    form.programTypeId = lang
    form.source = "//#{Time.now.to_s} #{code}"
    form.submit
    #get result
    #log out
    agent.page.link_with("text" => "Logout").click
  end
end
