import React, { useContext } from "react";
import AuthContext from '@/context/AuthContext'

interface DownloadLinkProps {
  url: string;
  fileName: string;
}

export const DownloadLink = ({ url, fileName }: DownloadLinkProps) => {
    const {
      authTokens,
      setLoader,
  
    } = useContext(AuthContext)!;

  const handleDownload = () => {
    setLoader(true)
    fetch(url, {
      headers: {
        Authorization: `Bearer ${authTokens?.access}`, // Add your authorization header here
      },
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.blob();
      })
      .then((blob) => {
        const fileURL = window.URL.createObjectURL(blob);
        const link = document.createElement("a");
        link.href = fileURL;
        link.download = fileName || "downloaded-file.pdf";
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        window.URL.revokeObjectURL(fileURL);
        setLoader(false)
      })
      .catch((error) => {
        console.error("Error fetching the file:", error);
        setLoader(false)
    });
  };

  return (
    <button className="site-btn px-2" type="button" onClick={handleDownload}>
      Download
    </button>
  );
};
