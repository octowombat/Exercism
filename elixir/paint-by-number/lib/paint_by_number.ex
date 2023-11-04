defmodule PaintByNumber do
  @empty_picture <<>>
  @test_picture <<0::2, 1::2, 2::2, 3::2>>

  def palette_bit_size(color_count) do
    num_bits(color_count, 0)
  end

  defp num_bits(color_count, power_of_2) do
    case Integer.pow(2, power_of_2) do
      p when p >= color_count -> power_of_2
      _other -> num_bits(color_count, power_of_2 + 1)
    end
  end

  def empty_picture, do: @empty_picture

  def test_picture, do: @test_picture

  def prepend_pixel(picture, color_count, pixel_color_index) do
    nb = palette_bit_size(color_count)
    <<pixel_color_index::size(nb), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _color_count), do: nil

  def get_first_pixel(picture, color_count) do
    nb = palette_bit_size(color_count)
    <<first::size(nb), _rest::bitstring>> = picture
    first
  end

  def drop_first_pixel(<<>>, _color_count), do: @empty_picture

  def drop_first_pixel(picture, color_count) do
    nb = palette_bit_size(color_count)
    <<_first::size(nb), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(<<>>, <<>>), do: <<>>
  def concat_pictures(<<>>, picture), do: picture
  def concat_pictures(picture, <<>>), do: picture

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
