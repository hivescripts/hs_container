import React, { Context, createContext, useContext, useEffect, useState } from "react"
import { useNuiEvent } from "../hooks/useNuiEvent"
import { fetchNui } from "../utils/fetchNui"
import { isEnvBrowser } from "../utils/misc"

const VisibilityCtx = createContext<VisibilityProviderValue | null>(null)

interface VisibilityProviderValue {
    setVisible: (visible: boolean) => void
    visible: boolean
    setCloseable: (closable: boolean) => void
    closeable: boolean
}

export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [visible, setVisible] = useState(isEnvBrowser())
    const [closeable, setCloseable] = useState(false)

    useNuiEvent<boolean>('setVisible', setVisible)

    useEffect(() => {
        if (!visible) return

        const keyHandler = (e: KeyboardEvent) => {
            if(!closeable) return
            if(!["Escape"].includes(e.code)) return
            if (!isEnvBrowser()) fetchNui("hideFrame")
            setVisible(false)
        }

        window.addEventListener("keydown", keyHandler)

        return () => window.removeEventListener("keydown", keyHandler)

    }, [visible, closeable])

    return (
        <VisibilityCtx.Provider value={{visible, setVisible, closeable, setCloseable}}>
            <div style={{ visibility: visible ? 'visible' : 'hidden'}}>
                {children}
            </div>
        </VisibilityCtx.Provider>
    )
}

export const useVisibility = () => useContext<VisibilityProviderValue>(VisibilityCtx as Context<VisibilityProviderValue>)