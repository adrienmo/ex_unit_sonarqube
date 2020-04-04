# ExUnit Sonarqube

Show desktop notifications for ExUnit runs. Works very well with automatic test runners such as [mix-test.watch](https://github.com/lpil/mix-test.watch). (Yes, TDD is awesome!)

Currently notifications on OS X and Linux are supported.

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
