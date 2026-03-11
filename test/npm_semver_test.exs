defmodule NPMSemverTest do
  use ExUnit.Case
  doctest NPMSemver

  @fixtures_dir Path.join(__DIR__, "fixtures")

  describe "range-include (version satisfies range)" do
    @include_fixtures @fixtures_dir
                      |> Path.join("range-include.json")
                      |> File.read!()
                      |> :json.decode()

    for {%{"range" => range, "version" => version, "loose" => loose, "includePrerelease" => include_pre}, idx} <-
          Enum.with_index(@include_fixtures) do
      @tag :"include_#{idx}"
      test "##{idx}: #{inspect(range)} includes #{inspect(version)}#{if loose, do: " (loose)"}#{if include_pre, do: " (includePrerelease)"}" do
        opts =
          []
          |> then(&if(unquote(loose), do: [{:loose, true} | &1], else: &1))
          |> then(&if(unquote(include_pre), do: [{:include_prerelease, true} | &1], else: &1))

        assert NPMSemver.matches?(unquote(version), unquote(range), opts),
               "Expected #{inspect(unquote(range))} to include #{inspect(unquote(version))}"
      end
    end
  end

  describe "range-exclude (version does not satisfy range)" do
    @exclude_fixtures @fixtures_dir
                      |> Path.join("range-exclude.json")
                      |> File.read!()
                      |> :json.decode()

    for {%{"range" => range, "version" => version, "loose" => loose, "includePrerelease" => include_pre}, idx} <-
          Enum.with_index(@exclude_fixtures) do
      if is_binary(version) do
        @tag :"exclude_#{idx}"
        test "##{idx}: #{inspect(range)} excludes #{inspect(version)}#{if loose, do: " (loose)"}#{if include_pre, do: " (includePrerelease)"}" do
          opts =
            []
            |> then(&if(unquote(loose), do: [{:loose, true} | &1], else: &1))
            |> then(&if(unquote(include_pre), do: [{:include_prerelease, true} | &1], else: &1))

          refute NPMSemver.matches?(unquote(version), unquote(range), opts),
                 "Expected #{inspect(unquote(range))} to exclude #{inspect(unquote(version))}"
        end
      end
    end
  end
end
