require "rspec/commit_specifier/version"
require "rugged"

module RSpec
  module GitSpecifier
    def repository
      Rugged::Repository.discover(current_directory)
    end

    def current_directory
      Dir.pwd
    end

    def commits
      walker.walk
    end

    def walker
      walker = Rugged::Walker.new(repository)
      walker.sorting(Rugged::SORT_DATE | Rugged::SORT_REVERSE)
      walker.push('HEAD')
      walker.hide(master_object_id)
      walker
    end

    def master_object_id
      repository.ref('refs/remotes/origin/master').target_id
    end
  end
end
