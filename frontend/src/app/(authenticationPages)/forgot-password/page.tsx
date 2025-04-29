'use client';
import { useForm } from "react-hook-form";
import React, { useContext, useState } from 'react'
import Image from 'next/image';
import "../../../css/authCss/auth.css"
import Link from 'next/link';
import AuthContext from "@/context/AuthContext";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEye, faEyeSlash } from "@fortawesome/free-solid-svg-icons";
const ForgetPassword = () => {
  
  const { 
    username,
    setUsername,


    disableButton,
    setDisableButton,
    loader,
    setLoader,

    alertVisible,
    setAlertVisible,
    isSuccess,

    LoginUser,

  } = useContext(AuthContext)!

  const[ showPassword, setShowPassword] = useState(false)

  const toogleShowPassword = () =>{
    setShowPassword(!showPassword)
  }

  type FormData = {
    username: string;
  }


  const {register, handleSubmit, formState: { errors, isValid }} = useForm<FormData>();

  const onSubmit = (data: FormData, e:any) => {
    // if(isValid){
    //   console.log(data)
    //   LoginUser(e)
    // }else{
    //   console.log('error')
    //   setDisableButton(false)
    // }

    LoginUser(e)
  }

  return (
    <div className='container-lg pt-5'>
      <div className="row justify-content-center align-center">
        <div className="col-lg-10">
          <div className="site-boxes py-5 px-4 border-radius-5px">
            <div className="row g-5">
              <div className="col-md-6">
                <div className="d-none d-md-block">
                  <div className="d-flex align-center">
                    <div>
                      <Image  className='logo' src="/img/logo.png" alt="Logo" width={100} height={100} />
                      <p className='pt-4 lg-text font-bold auth-header'>Empowering Education with Smart Management</p>
                      <p className='light-text'>""Simplify student enrollment, performance tracking, and communication in one powerful platform."</p>
                      <p className="light-text xsm-text italic-text">"The function of education is to teach one to think intensively and to think critically." — Martin Luther King Jr.</p>
                    </div>
                  </div>
                </div>
              </div>

              {/* <div className="col-6 ">
                <div style={{ position: 'relative', width: '100%', height: '580px' }}> 
                  <Image className='border-radius-5px' src="/img/auth/login.jpg" alt="Logo" fill priority style={{ objectFit: 'cover' }} />
                </div>
              </div> */}

              <div className="col-md-6">
                <div>
                  <div className="d-block d-md-none pb-3">
                    <div className="d-flex align-center">
                      <div>
                        <Image  className='logo' src="/img/logo.png" alt="Logo" width={100} height={100} />
                      </div>
                    </div>
                  </div>
                  <p className='lg-text font-bold auth-header pb-4 primary-text'>Forget Password</p>
                  <form onSubmit={handleSubmit(onSubmit)}>
                    <div className="row g-3">
                      <div className="col-12">
                        <label className="form-label">Username</label>
                        <input 
                          type="text" className={`${errors.username ? 'error-input' : ''}  site-input`}
                          {...register("username", { required: true })}
                          value={username}
                          onChange={(e) => setUsername(e.target.value)}
                          placeholder="Enter your username"
  
                        />

                        {errors.username && <p className="error-text">This field is required</p>}
                      </div>


                      <div className="col-12">
                        <div className="d-flex justify-content-between">
                          <div>
                            <p><Link className="blue-link form-label" href='/forgot-password'>login</Link></p>
                          </div>
                        </div>
                      </div>

                      <div className="col-12">
                      <button disabled={disableButton} type="submit" className={`Button site-btn width-100`}>
                        <span className={`${loader ? 'site-submit-spinner': ''}`}></span>
                        <span className={`${loader ? 'site-submit-btn-visiblity': ''}`}>Submit</span>
                      </button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default ForgetPassword