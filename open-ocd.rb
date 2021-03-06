require 'formula'


# https://raw.githubusercontent.com/gnuarmeclipse/build-scripts/master/scripts/build-openocd.sh

class OpenOcd < Formula

  desc "On-chip debugging, in-system programming and boundary-scan testing"
  homepage "http://sourceforge.net/projects/openocd/"
  url "https://downloads.sourceforge.net/project/openocd/openocd/0.9.0/openocd-0.9.0.tar.bz2"
  sha256 "837042ac9a156b9363cbffa1fcdaf463bfb83a49331addf52e63119642b5f443"

  option "without-libusb", "Disable building support for generic USB adapters"
  option "without-stlink", "Disable building driver for STLink"

  depends_on "pkg-config" => :build
  depends_on "libusb" => :recommended
  # some drivers are not converted to libusb-1.0
  depends_on "libusb-compat" if build.with? "libusb"


  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-dummy
      --enable-buspirate
      --enable-stlink
      --enable-jtag_vpi
      --enable-remote-bitbang

     --disable-parport
     --disable-parport-ppdev
     --disable-parport-giveio
    ]

    system "./configure", *args
    system "make", "install"
  end
end

