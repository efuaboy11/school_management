"use client"

import { profile } from 'console';
import {jwtDecode} from 'jwt-decode';
import { createContext, useEffect, useState } from "react";
import { ReactNode } from "react";
import { useRouter } from 'next/navigation';
import validator from 'validator';

interface AuthContextType {
  captchaToken: string | null;
  setCaptchaToken: (token: string | null) => void;  
  activateCaptcha: boolean;
  setActivateCaptcha: (activate: boolean) => void;
  userProfile: any;
  setUserProfile: (profile: any) => void;
  username: string;
  setUsername: (username: string) => void;
  password: string;
  setPassword: (password: string) => void;
  disableButton: boolean;
  setDisableButton: (disable: boolean) => void;
  loader: boolean;
  setLoader: (loading: boolean) => void;
  copied: boolean;
  setCopied: (copied: boolean) => void;
  overlay: boolean;
  setOverlay: (overlay: boolean) => void;
  showSidebar: boolean;
  setShowSidebar: (show: boolean) => void;
  toggleShowSidebar: () => void;
  toggleCloseSidebar: () => void;
  toggleClientSidebar: () => void;
  OnbodyClick: () => void;
  messages: string;
  setMessage: (message: string) => void;
  alertVisible: boolean;
  setAlertVisible: (visible: boolean) => void;
  isSuccess: boolean;
  setIsSuccess: (success: boolean) => void;
  errorMessages: string;
  setErrorMessage: (error: string) => void;
  formatDate: (dateString: string) => string;
  formateDateTime: (dateString: string) => string;
  formatCurrency: (amount: number) => string;
  roundUp: (value: number) => number;
  formatName: (name: string) => string;
  formatNameAllCaps: (name: string) => string;
  shortName: (name: string) => string;
  formatFirstName: (name: string) => string;
  truncateText: (text: string, wordLimit: number) => string;
  handleCopy: (text: string) => void;
  showAlert: () => void;
  updateDateTime: () => void;
  currentDateTime: string;
  ImageHandler: (event: any) => void; 
  userDetails: () => void;
  LoginUser: (e: any) => Promise<void>;

}


const AuthContext = createContext<AuthContextType | undefined>(undefined);
export default AuthContext

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [captchaToken, setCaptchaToken] = useState<any>(null);
  const [activateCaptcha, setActivateCaptcha] = useState(false)

  const [userProfile, setUserProfile] = useState<any>(null)
  const [username, setUsername] = useState<string>('')
  const [password, setPassword] = useState<string>('')

  const [disableButton, setDisableButton] = useState(false)
  const [loader, setLoader] = useState(false)
  const [copied, setCopied] = useState(false)
  const [overlay, setOverlay] = useState(false)

  const [showSidebar, setShowSidebar] = useState(false)

  const [messages, setMessage] = useState<string>('')
  const [alertVisible, setAlertVisible] = useState(false);
  const [isSuccess, setIsSuccess] = useState(true)
  const [errorMessages, setErrorMessage] = useState('')

  const [currentDateTime, setCurrentDateTime] = useState<string>("");

  const router = useRouter();

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    const day = date.getDate()
    const month = date.toLocaleString('en-US', { month: 'short' });
    const year = date.getFullYear();
    return `${day} ${month} ${year}`;
  }


  const formateDateTime = (dateString: string) => {
    const date = new Date(dateString);
        
    const day = date.getDate();
    const month = date.toLocaleString('en-US', { month: 'short' });
    const year = date.getFullYear();
    
    const hours = date.getHours();
    const minutes = date.getMinutes().toString().padStart(2, '0');
    const period = hours >= 12 ? 'PM' : 'AM';
    const formattedHours = hours % 12 || 12; // Convert to 12-hour format, making 0 into 12
    
    return `${day} ${month} ${year} ${formattedHours}:${minutes} ${period}`;
  } 


  const formatCurrency = (amount:number) => {
    return amount.toLocaleString('en-US', {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    }); 
  };

  const roundUp = (value: number) => {
    return Math.ceil(value);
  }

  const toggleShowSidebar = () =>{
    setShowSidebar(true)
  }

  const toggleCloseSidebar = () =>{
    setShowSidebar(false)
  }
  const toggleClientSidebar = () =>{
    setShowSidebar(!showSidebar)
  }
  const OnbodyClick = () =>{
    if (showSidebar){
      setShowSidebar(false)
    }
  }

  const showAlert = () => {
    setAlertVisible(true);
    setTimeout(() => {
      setAlertVisible(false);
    }, 7000); 
  };


  const formatName = (name:string) => {
      return name
        .split(" ") // Split the name by spaces
        .map((word) => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()) // Capitalize the first letter of each word
        .join(" "); // Join the words back together
  };

  const formatNameAllCaps = (name:string) => {
      return name
        .split(" ") // Split the name by spaces
        .map((word) => word.toUpperCase()) // Capitalize the first letter of each word
        .join(" "); // Join the words back together
  };

  const shortName = (name:string) => {
      return name
        .split(" ") // Split the name by spaces
        .map((word) => word.charAt(0).toUpperCase()) // Take the first letter of each word
        .join(""); // Join the letters together
  };

  const formatFirstName = (name:string) =>{
      const firstName = name.split(" ")[0]
      return firstName.charAt(0).toUpperCase() + firstName.slice(1).toLowerCase()
  }

  const truncateText = (text:string, wordLimit:number) => {
    const words = text.split(' ');
    if (words.length > wordLimit) {
      return words.slice(0, wordLimit).join(' ') + '...';
    }
    return text;
  };

  const handleCopy = (text:string) => {
    navigator.clipboard.writeText(text)
      .then(() => {
        setCopied(true)
      })
      .catch((err) => {
        console.error("Failed to copy text: ", err);
      });
  };

  useEffect(() => {
    if (copied) {
      const timer = setTimeout(() => {
        setCopied(false);
      }, 1000); // Reset after 1 second

      return () => clearTimeout(timer); // Cleanup the timer to avoid memory leaks
    }
  }, [copied]);

  const updateDateTime = () => {
    const now = new Date();

    // Format the date
    const day = now.getDate();
    const month = now.toLocaleString("default", { month: "short" }); // "Dec"
    const year = now.getFullYear();

    // Format the time
    const hours = now.getHours() % 12 || 12; // Convert to 12-hour format
    const minutes = String(now.getMinutes()).padStart(2, "0"); // Add leading zero
    const ampm = now.getHours() >= 12 ? "PM" : "AM";

    // Combine into desired format
    const formattedDateTime = `${day} ${month} ${year} ${hours}:${minutes} ${ampm}`;

    setCurrentDateTime(formattedDateTime);
  };

  const ImageHandler = (event:any) =>{
    if (event.target.files.length > 0) {
      const file = event.target.files[0];
      const fileSizeInKB = file.size / 1024; // Convert bytes to KB
      const fileType = file.type;

      // Validate file size (10KB to 5120KB)
      if (fileSizeInKB < 10 || fileSizeInKB > 5120) {
        setErrorMessage("File size must be between 10KB and 5120KB.");
        return false;
      }

      // Validate file type (jpg/jpeg/png)
      if (!["image/jpeg", "image/png"].includes(fileType)) {
        setErrorMessage("File must be in JPG, JPEG, or PNG format.");
        return false;
      }

      return true
    }
    return false;
  }


  const userDetails = async()=>{
    try{
      const response = await fetch(
        `http://127.0.0.1:8000/api/user-profile/`,
        {
          method: "GET",
          credentials: "include",
          headers: {
            "Content-Type": "application/json",
          },
        }
      );

      const data = await response.json();

      if(response.status === 200){
        setUserProfile(data)
        console.log(data)
        setDisableButton(false);
      }else{
        console.error("Failed to fetch user details:", response.statusText);
      }

    }catch(error){
      console.log(error);
    }
  }

  const roleRoutes: Record<string, string> = {
    admin: '/admin/home',
    hr: '/hr/home',
    student: '/student/home',
    teacher: '/teacher/home',
    bursary: '/bursary/home',
    store_keeper: '/store-keeper/home',
    exam_officer: '/exam-officer/home',
    academic_officer: '/academic-officer/home',
    other_staff: '/other-staff/home',
  };
  console.log(disableButton)
  const LoginUser = async (e:any) => {
    e.preventDefault();
    setLoader(true)

    setDisableButton(true);
    const sanitizedUsername = validator.escape(username);
    const sanitizedPassword = validator.escape(password); 

    try{
      let response = await fetch('http://127.0.0.1:8000/api/login/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username: sanitizedUsername,
          password: sanitizedPassword,
        })
      })

      const data = await response.json();
      if(response.status === 200){
        console.log(data);
        setMessage("Login Sucessfull")
        showAlert()
        setIsSuccess(true)
        setDisableButton(false)
        setLoader(false)

        
        const route = roleRoutes[data.role];
        if (route) {
          // await userDetails()
          // router.push(route);
        } else {
          console.error('Unknown role:', data.role);
          // Maybe navigate to a default page or show an error
        }
      }else{
        const errorData = await response.json()
          const errorMessages = Object.values(errorData)
          .flat()
          .join(', ');
        setMessage(errorMessages)
        setDisableButton(false)
        setIsSuccess(false)
        showAlert()
      }


    }catch(error){
      console.log(error)
      showAlert()
      setMessage('An unexpected error occurred. Please check your email and password or contact support');
      setDisableButton(false)
      setIsSuccess(false)

    }

  }


  const contextData = {
    captchaToken,
    setCaptchaToken,
    activateCaptcha,
    setActivateCaptcha,
    userProfile,
    setUserProfile,
    username,
    setUsername,
    password,
    setPassword,
    disableButton,
    setDisableButton,
    loader,
    setLoader,
    copied,
    setCopied,
    overlay,
    setOverlay,
    showSidebar,
    setShowSidebar,
    toggleShowSidebar,
    toggleCloseSidebar,
    toggleClientSidebar,
    OnbodyClick,
    messages,
    setMessage,
    alertVisible,
    setAlertVisible,
    isSuccess,
    setIsSuccess,
    errorMessages,
    setErrorMessage,
    formatDate,
    formateDateTime,
    formatCurrency,
    roundUp,
    formatName,
    formatNameAllCaps,
    shortName,
    formatFirstName,
    truncateText,
    handleCopy,
    showAlert,
    updateDateTime,
    currentDateTime,
    ImageHandler,
    userDetails,
    LoginUser,

    

  }
  return (
    <AuthContext.Provider value={contextData}>
      {children}
    </AuthContext.Provider>
  );
}
