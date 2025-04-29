import React from "react";
import AuthNavbar from "@/components/authNavbar";
const RootLayout = ({ children }: { children: React.ReactNode }) => {   
  return (
   <div>
      <AuthNavbar />
      <div>{children}</div>
   </div>
  );
}

export default RootLayout;