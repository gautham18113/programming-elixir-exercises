defmodule Duper.ResultsTest do

  use ExUnit.Case
  alias Duper.Results

  test "can add entries to results" do
    Results.add_hash_for("Path1", 123)
    Results.add_hash_for("Path2", 234)
    Results.add_hash_for("Path3", 456)
    Results.add_hash_for("Path5", 234)
    Results.add_hash_for("Path6", 678)
    Results.add_hash_for("Path7", 123)

    duplicates = Results.find_duplicates()

    assert length(duplicates) == 2

    assert ~w{Path7 Path1} in duplicates
    assert ~w{Path5 Path2} in duplicates
  end
end
