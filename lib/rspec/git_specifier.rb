require "rspec/git_specifier/version"
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

    def current_branch
      travis_branch || repository.branches.detect(&:head?)
    end

    def travis_branch
      name = ENV['TRAVIS_BRANCH']
      return unless name

      repository.branches.detect do |branch|
        branch.name == name
      end
    end
  end
end
