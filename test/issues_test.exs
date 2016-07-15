defmodule IssuesTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1]
  import Issues.GithubIssues, only: [test_fetch: 2]

  test ":help returned with option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help

  end

  test " three values returned when three passed" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end  

  test "count defaults to 4 if only two variables are passed" do
    assert parse_args(["user","project"]) == { "user", "project", 4}
  end  

  test "get correct response from github" do
    assert test_fetch("elixir-lang", "elixir") == {200, "anything" }
  end  
end
