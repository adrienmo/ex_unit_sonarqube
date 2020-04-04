# ExUnit Sonarqube

Generate a generic test execution file to be used with SonarQube

```
GENERIC_EXECUTION_BASE_FOLDER="base/folder" mix test
```

## Installation

First, add `ExUnitSonarqube` to your `mix.exs` dependencies:

```elixir
def deps do
  [{:ex_unit_sonarqube, "~> 0.1", only: :test}]
end
```

## Usage

Add `ExUnitSonarqube` to your `ExUnit` configuration in `test/test_helper.exs` file.

```elixir
ExUnit.configure formatters: [ExUnit.CLIFormatter, ExUnitSonarqube]
ExUnit.start
```

Now run `mix test` and you should see a file created `generic_test_execution_sonarqube.xml`
