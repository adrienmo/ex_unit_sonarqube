defmodule ExUnitSonarqube do
  @moduledoc """
  Create generic test execution file for SonarQube
  """

  use GenServer
  alias ExUnit.Test

  @filename "generic_test_execution_sonarqube.xml"

  def init(_opts), do: {:ok, %{}}

  def handle_cast(
        {:test_finished,
         %Test{tags: %{file: file}, module: module, name: name, time: time, state: state}},
        acc
      ) do
    test = %{
      name: String.replace("#{module} | #{name}", ["<", ">", "&", "\"", "'"], ""),
      duration: time,
      message: "",
      state: parse_state(state)
    }

    base_dir = System.get_env("GENERIC_EXECUTION_BASE_FOLDER", "/")
    file = Path.relative_to(file, base_dir)
    acc = Map.update(acc, file, [test], &[test | &1])
    {:noreply, acc}
  end

  def handle_cast({:suite_finished, _, _}, acc) do
    :ok = acc |> format() |> save_to_file()
    {:noreply, acc}
  end

  def handle_cast({:test_started, _}, acc), do: {:noreply, acc}
  def handle_cast({:suite_started, _}, acc), do: {:noreply, acc}
  def handle_cast({:case_started, _}, acc), do: {:noreply, acc}
  def handle_cast({:case_finished, _}, acc), do: {:noreply, acc}
  def handle_cast({:module_started, _}, acc), do: {:noreply, acc}
  def handle_cast({:module_finished, _}, acc), do: {:noreply, acc}
  def handle_cast(_unhandled, acc), do: {:noreply, acc}

  defp parse_state(nil), do: :passed
  defp parse_state({:failed, _}), do: :failed
  defp parse_state({:skipped, _}), do: :skipped
  defp parse_state({state, _}), do: IO.inspect(state)

  defp format(acc) do
    "<testExecutions version=\"1\">" <>
      Enum.map_join(acc, fn {path, tests} ->
        path = String.replace("#{path}", ~r/(\/)+/, "/", global: true)

        "<file path=\"#{path}\">" <>
          Enum.map_join(tests, fn %{duration: duration, name: name, state: state} ->
            duration = div(duration, 1000)
            message = case state do
              :passed -> ""
              :skipped ->
                "<skipped message=\"skipped\"></skipped>"
              :failed ->
                "<failure message=\"failure\"></failure>"
            end
            "<testCase name=\"#{name}\" duration=\"#{duration}\">#{message}</testCase>"
          end) <>
          "</file>"
      end) <> "</testExecutions>"
  end

  defp save_to_file(content), do: File.write!(@filename, content)
end
