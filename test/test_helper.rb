module TestHelper
  def reset_directory
    Dir.chdir('../..')
  end

  def chdir_to_standard
    Dir.chdir('test/fixtures/standard_fs')
  end

  def chdir_to_empty
    Dir.chdir('test/fixtures/empty_fs')
  end
end
