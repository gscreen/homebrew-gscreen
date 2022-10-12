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
  version "1.2.0"
  url "https://gscreen-releases.s3.amazonaws.com/v#{version}/gscreen-macos-#{arch}.bin.tar.gz"

  @@filename = "gscreen-macos-#{arch}.bin"

  sha256 case arch
  when "amd64" then "2b4bfdc1d3da593ead54b7a025f06597f5953e8a8e823867b8a74dfa08d73d07"
  when "arm64" then "598df19f34dbfdd6bda3383627bc065a8abdc1be400f1e5936a4e588d92424bc"
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
