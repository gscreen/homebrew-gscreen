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
  version "0.4.0"
  url "https://gscreen-releases.s3.amazonaws.com/v#{version}/gscreen-macos-#{arch}.bin.tar.gz"

  @@filename = "gscreen-macos-#{arch}.bin"

  sha256 case arch
  when "amd64" then "a62e5df333559d9c574ea570ae419560786b7b30867cd8136820b13a01e80a21"
  when "arm64" then "ca22d8fa111182882e9604654a25b4683b0ecfc0caf314c889cf49281ae3b02c"
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
