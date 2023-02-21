import React, { Context, createContext, useContext, useState } from "react"
import { useNuiEvent } from "../hooks/useNuiEvent"

const LanguageCtx = createContext<LanguageProviderValue | null>(null)

interface LanguageProviderValue {
    getString: (key: string) => string
}

interface ReceivingData {
    key: string
    value: string | ReceivingData[]
}

export const LanguageProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [languageMap, setLanguageMap] = useState<Record<string, string>>({})

    const getString = (key: string) => {
        return languageMap[key] || key
    }

    // format of received data can be key: value OR key: {key: value, key: value, ...}
    // so, use a dot to nest the keys
    const formatData = (data: ReceivingData[]) => {
        const formattedData: Record<string, string> = {}
        
        // get all strings recursively
        const getStrings = (data: ReceivingData[] | ReceivingData, prefix: string = '') => {
            Object.entries(data).forEach(([key, value]) => {
                if (typeof value === 'string') {
                    formattedData[prefix + key] = value
                } else {
                    getStrings(value, prefix + key + '.')
                }
            })
        }

        getStrings(data)

        return formattedData
    }

    useNuiEvent<ReceivingData[]>('localeStrings', (data) => {
        const formattedData = formatData(data)
        setLanguageMap(formattedData)
    })

    return (
        <LanguageCtx.Provider value={{getString}}>
            {children}
        </LanguageCtx.Provider>
    )
}

export const useLanguage = () => useContext<LanguageProviderValue>(LanguageCtx as Context<LanguageProviderValue>)