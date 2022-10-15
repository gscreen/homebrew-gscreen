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
  version "0.5.0"
  url "https://gscreen-releases.s3.amazonaws.com/v#{version}/gscreen-macos-#{arch}.bin.tar.gz"

  @@filename = "gscreen-macos-#{arch}.bin"

  sha256 case arch
  when "amd64" then "c4fc41a001fc050961982997301ca6235ef30bd5e6eaf90eca944ec1df3f1b60"
  when "arm64" then "b0b154e0911435fb6695dde4b887c566955148d966fa702871d7abc6e7d4b104"
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
