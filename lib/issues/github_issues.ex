defmodule Issues.GithubIssues do
    @user_agent [ {"User-agent","Elixir ved.antani@gmail.com" }]
    def test_fetch(user, project) do
        fetch(user, project)
    end    
    def fetch(user,project) do
        issues_url(user,project)
        |>HTTPoison.get(@user_agent)
        |>handle_response
    end 
    defp issues_url(user,project) do
        "https://api.github.com/repos/#{user}/#{project}/issues"
    end  
    def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do 
        {:ok,Poison.decode(body)} 
    end     
    def handle_response({:error, %HTTPoison.Response{status_code: ___, body: body}}) do 
        :error
    end     
        
end