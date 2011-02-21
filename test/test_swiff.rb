require 'helper'

class TestSwfutil < Test::Unit::TestCase
  should "take the filename as a mandatory parameter" do
    assert_nothing_raised do
      swiff = Swiff.new fixture_path('clicktag.swf')
    end
  end

  context "a file" do
    setup do
      @swiff = Swiff.new fixture_path('clicktag.swf')
    end

    should "be able to determine whether it is compressed" do
      assert_equal true, @swiff.is_compressed?
    end

    should "be able to determine whether it is not compressed" do
      @swiff = Swiff.new fixture_path('clicktag-decompressed.swf')
      assert_equal false, @swiff.is_compressed?
    end

    should "be able to determine file is a swf" do
      assert_equal true, @swiff.is_swf?

      @not_swiff = Swiff.new fixture_path('smallgoat.jpg')

      assert_equal false, @not_swiff.is_swf?
    end

    should "determine the flash version of the file" do
      assert_equal 8, @swiff.version
    end

    should "determine width and height" do
      assert_equal 468, @swiff.width
      assert_equal 60, @swiff.height
    end

    should "determine the frame rate" do
      assert_equal 24, @swiff.frame_rate
    end

    should "determine maximum x value" do
      assert_equal 9360, @swiff.x_max
    end

    should "determine maximum y value" do
      assert_equal 1200, @swiff.y_max
    end

    should "determine frame count" do
      assert_equal 1, @swiff.frame_count
    end

    should "be able to decompress a file" do
      decompressed_file = File.open(fixture_path('clicktag-decompressed.swf'), 'rb') { |f| f.read }
      assert_equal decompressed_file, @swiff.decompress
    end

    should "be able to compress a file" do
      @swiff = Swiff.new fixture_path('clicktag-decompressed.swf')
      compressed_file = File.open(fixture_path('clicktag.swf'), 'rb') { |f| f.read }
      assert_equal compressed_file, @swiff.compress
    end
  end

  context 'with different input formats' do
    should 'read a SWF from a path' do
      swiff = Swiff.new(fixture_path('clicktag.swf'), :input => :path)
      assert_equal true, swiff.is_swf?
    end

    should 'default to path' do
      swiff = Swiff.new(fixture_path('clicktag.swf'))
      assert_equal true, swiff.is_swf?
    end
    
    should 'read a SWF from a byte array' do
      bytes = File.open(fixture_path('clicktag.swf'), 'rb') { |f| f.read }
      swiff = Swiff.new(bytes, :input => :bytes)
      assert_equal true, swiff.is_swf?
    end

    should 'raise an error for unsupported input formats' do
      assert_raise(ArgumentError) do
        Swiff.new('hello', :input => :foo)
      end
    end
  end
  
  context 'with bytes as input' do
    setup do
      bytes = File.open(fixture_path('clicktag.swf'), 'rb') { |f| f.read }
      @swiff = Swiff.new(bytes, :input => :bytes)
    end
    
    should 'determine width and height' do
      assert_equal 468, @swiff.width
      assert_equal 60, @swiff.height
    end
    
    should 'determine the full size' do
      # in the original (file-only) implementation this implementation depends
      # on reading a couple of bytes from the start of the file, without reading
      # the whole thing, this needs special handling if the input type is bytes
      assert_equal 4156, @swiff.read_full_size
    end
  end
end
