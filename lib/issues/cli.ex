defmodule Issues.CLI do
    @defaultcount 4
    @moduledoc """
    Handle the command line parsing and dispatch of various functions
    """

    def run(argv) do
        argv
            |> parse_args
            |> process
    end    

    @doc """
    argv can be -h or --help which returns :help
    otherwise it should be a github user and project name
    """

    def parse_args(argv) do
        parse = OptionParser.parse(argv, switches: [help: :boolean],
                                         aliases: [h: :help])
        IO.inspect parse

        case parse do
            {[help: true], _, _} -> :help
            { _, [user, project, count],_} -> {user, project, String.to_integer(count)}
            {_, [user ,project],_} -> {user, project , @defaultcount}
            _ -> :help
        end       
    end    

    def process(:help) do
        IO.puts """
        usage: issues <user> <project> [count | #{@defaultcount}]
        """
        System.halt(0)
    end    
    def process(user, project, _count) do
        Issues.GithubIssues.fetch(user,project)
    end    
end
