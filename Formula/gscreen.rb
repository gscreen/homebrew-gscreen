require_relative "../utils/codesign"

class Gscreen < Formula
  arch = case Hardware::CPU.arch
  when :x86_64 then "amd64"
  when :arm64 then "arm64"
  else
    raise "gScreen: Unsupported system architecture #{Hardware::CPU.arch}"
  end

  desc "Slideshows across all your Google Photos media"
  homepage "https://photoscreensaver.app"
  version "0.4.1"
  url "https://gscreen-releases.s3.amazonaws.com/v#{version}/gscreen-macos-#{arch}.bin.tar.gz"

  @@filename = "gscreen-macos-#{arch}.bin"

  sha256 case arch
  when "amd64" then "ad5d804d35ab47752e5412ac173328fe44b48f77f4d6e33f95d53d98e3b768ca"
  when "arm64" then "d37d4618f2a40b53ade51c2374667a409fb4f128a5cb1113a2d66e35be981f3b"
  else
    raise "gScreen: Unsupported system #{arch}"
  end

  def install
    filename = if stable.using.blank?
      Gscreen.class_variable_get(:@@filename)
    else
      downloader.cached_location
    end
    apply_ad_hoc_signature(filename)
    bin.install filename => "gscreen"
  end
end
