import Nav from "components/Nav";
import Spinner from "components/Spinner";
import React from "react";
import { Helmet } from "react-helmet-async";

const Layout = ({ children, title, loading }) => {
  return (
    <>
      <Helmet>
        <meta charSet="utf-8" />
        <title>{title || "Home"} | PERN Store </title>
        <meta
          name="description"
          content="Ecommerce store built with React, Node, Express and Postgres"
        />
        <meta
          name="robots"
          content="max-snippet:-1, max-image-preview:large, max-video-preview:-1"
        />
        <link rel="canonical" href="https://pern-store.netlify.app/" />
        <meta property="og:locale" content="en_US" />
        <meta property="og:type" content="website" />
        <meta property="og:title" content="PERN Store" />
        <meta
          property="og:description"
          content="Ecommerce store built with React, Node, Express and Postgres"
        />
        <meta property="og:url" content="https://pern-store.netlify.app/" />
        <meta property="og:site_name" content="PERN Store" />
        <meta property="og:image" content="android-chrome-512x512.png" />
        <meta
          property="og:image:secure_url"
          content="android-chrome-512x512.png"
        />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:site" content="@_odunsi_" />
        <meta name="twitter:creator" content="@_odunsi_" />
        <meta
          name="twitter:description"
          content="Ecommerce store built with React, Node, Express and Postgres"
        />
        <meta name="twitter:title" content="PERN Store" />
        <meta name="twitter:image" content="android-chrome-512x512.png" />
        <style type="text/css">{`html,body{height: 100%;}`}</style>
      </Helmet>

      <div className="font-serif min-h-screen flex flex-col bg-gray-100">
        <Nav />
        {loading ? (
          <div className="">
            <Spinner size={100} loading />
          </div>
        ) :
          <main className="h-full">{children}</main>
        }
        <div className="w-full bg-white text-white">
          <div className="xl:px-40 pb-12 lg:px-20 md:px-10 sm:px-5 px-10">
            <div className="w-full pt-12 flex flex-col sm:flex-row space-y-2  justify-start">
              <div className="w-full sm:w-2/5 pr-6 flex flex-col space-y-4">
                <h1 className="text-gray-600 uppercase tracking-widest" style={{ fontSize: "45px", marginBottom: "0", paddingBottom: "0" }}><strong>Mobi Store</strong></h1>
                <h1 className="text-gray-600" style={{ letterSpacing: "7px", marginTop: "0", paddingTop: "0" }}>Smartphone hub</h1>
                <p className="text-gray-500 opacity-60">Shivalik-8, Chandan Park Main Rd, 
                Opp. Paradise Hall, Rajkot, Gujarat 360005.</p>
              </div>
              <div className="w-full text-gray-500 sm:w-1/5 flex flex-col space-y-4">
                <a href="#/" className="hover:text-gray-900 opacity-60">About Us</a>
                <a href="#/" className="hover:text-gray-900 opacity-60">Responsibilities</a>
                <a href="#/" className="hover:text-gray-900 opacity-60">Out Services</a>
                <a href="#/" className="hover:text-gray-900 opacity-60">Contact</a>
              </div>
              <div className="w-full text-gray-500 sm:w-1/5 flex flex-col space-y-4">
                <a href="#/" className="hover:text-gray-900 opacity-60">Disclaimer</a>
                <a href="#/" className="hover:text-gray-900 opacity-60">Testimonials</a>
                <a href="#/" className="hover:text-gray-900 opacity-60">Privacy Policy</a>
                <a href="#/" className="hover:text-gray-900 opacity-60">Terms of Service</a>
              </div>
              <div className="w-full sm:w-1/5 pt-6 flex items-end mb-1">
                <div className="flex text-gray-600 flex-row space-x-4">
                  <i className="fab fa-facebook-f"></i>
                  <i className="fab fa-twitter"></i>
                  <i className="fab fa-instagram"></i>
                  <i className="fab fa-google"></i>
                </div>
              </div>
            </div>
            <div className="text-gray-500 text-base leading-6 opacity-60 pt-2">
              <p>© 2022 MOBI Store —
                <a
                  href="https://github.com/Vishrant0281"
                  className="ml-1 hover:text-gray-900"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  @Vishrant0281
                </a></p>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Layout;
