'use client';
import React from "react";
import AuthNavbar from "@/components/authNavbar";
import FloatingAlert from "@/components/alert";
import { useContext } from "react";
import AuthContext from "@/context/AuthContext";
import AdminFrame from "@/components/dashboardFrames/adminFrame";



const RootLayout = ({ children }: { children: React.ReactNode }) => { 
  const { 
    alertVisible,
    setAlertVisible,
    isSuccess,
    messages,
    showSidebar,
  } = useContext(AuthContext)!
  
  
  return (
   <div>  
      <div>
        <FloatingAlert
          message={messages}
          isVisible={alertVisible}
          onClose={() => setAlertVisible(false)}
          successs={isSuccess}
        />
      </div>
      <div className="position-sticky1">
        <AdminFrame />
      </div>


      
      <div className={`dashboard-main-content ${showSidebar ? 'dash-sidebar-overlay': ''}`}>
        <div className="mt-4">
          {children}
        </div>
        
      </div>
   </div>
  );
}

export default RootLayout;