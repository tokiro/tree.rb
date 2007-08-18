require 'test/unit'

$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )
$:.unshift( File.join($COMMON_HOME, "test" ) )

require 'common/dirtreeprocessor'

class TestDirTreeProcessor < Test::Unit::TestCase

  def test_ignore_dir
    dtp = DirTreeProcessor.new( "." )

    dtp.add_ignore_dir(".xvpics")
    dtp.add_ignore_dir(".thumbnails")
    dtp.add_ignore_dir("catalog_data")

    assert( dtp.ignore_dir?( ".thumbnails" ) )
    assert( ! dtp.ignore_dir?( "pippo" ) )

  end


end