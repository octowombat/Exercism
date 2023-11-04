defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts()) :: {:ok, opts()} | {:error, error()}
  @callback handle_frame(dot(), frame_number(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      alias DancingDots.Animation

      @behaviour Animation

      @impl Animation
      def init(opts), do: {:ok, opts}

      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  alias DancingDots.Dot

  @impl Animation
  def handle_frame(%Dot{opacity: opacity} = dot, frame_number, _opts)
      when rem(frame_number, 4) == 0 do
    %Dot{dot | opacity: opacity / 2}
  end

  def handle_frame(dot, _frame_number, _opts), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  alias DancingDots.Dot

  @impl Animation
  def init(opts) do
    velocity = Keyword.get(opts, :velocity, nil)

    case is_number(velocity) do
      false ->
        {:error,
         "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}

      true ->
        {:ok, opts}
    end
  end

  @impl Animation
  def handle_frame(%Dot{radius: radius} = dot, frame_number, opts) do
    %Dot{dot | radius: radius + (frame_number - 1) * opts[:velocity]}
  end
end
