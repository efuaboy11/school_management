'use client';
import React from "react";
import AuthNavbar from "@/components/authNavbar";
import FloatingAlert from "@/components/alert";
import { useContext } from "react";
import AuthContext from "@/context/AuthContext";
import AdminFrame from "@/components/dashboardFrames/adminFrame";
import { DashboardFooter } from "@/components/dashFooter";
import "../../css/adminCss/staff.css"


const RootLayout = ({ children }: { children: React.ReactNode }) => { 
  const { 
    alertVisible,
    setAlertVisible,
    isSuccess,
    messages,
    showSidebar,
    OnbodyClick,
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


      
      <div className={`dashboard-main-content `}>
        <div className="mt-4" onClick={OnbodyClick}>

          <div>
            {children}

              {/* <DashboardFooter /> */}
           

          </div>
  


        </div>
        
      </div>
   </div>
  );
}

export default RootLayout;